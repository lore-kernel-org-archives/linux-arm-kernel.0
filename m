From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 9 Nov 2017 08:51:43 -0800
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <DAE9979D-29B4-4BD3-99E5-0E8273A7F8E0@linaro.org>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
 <20171109000222.GC8522@tassilo.jf.intel.com>
 <DAE9979D-29B4-4BD3-99E5-0E8273A7F8E0@linaro.org>
Message-ID: <20171109165143.GD10540@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 07:48:06AM +0300, Maxim Kuvyrkov wrote:
> Regarding CONFIG_* options, I would expect most of the configuration
> changes to be equally valid for both GCC's and Clang's LTO support.
> Sami, I don't think it's fair to ask you to support both Clang and GCC in
> your patchset, but, where changes are obviously toolchain-agnostic, could
> you use CONFIG_LTO?  And use CONFIG_LTO_CLANG for Clang-specific parts?

Sure, using CONFIG_LTO for common code and CONFIG_LTO_CLANG for clang-
specific parts sounds good.

Sami
