From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Oct 2012 13:23:52 -0600
Subject: [RFC PATCH 16/16] Documentation: Update samsung-pinctrl device
 tree bindings documentation
In-Reply-To: <1348842527-22460-17-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
 <1348842527-22460-17-git-send-email-t.figa@samsung.com>
Message-ID: <506DE248.6090709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 08:28 AM, Tomasz Figa wrote:
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

I think this binding looks reasonable now.

I'm not sure if this series works with "git bisect" though? For example,
perhaps you want to move patch 15 to the start so the new properties are
present before the code attempts to use them.
