From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 27 Aug 2013 12:22:47 +0100
Subject: [PATCH v4 0/5] ARM/ARM64 architected timer updates
In-Reply-To: <1377274749-6196-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377274749-6196-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130827112247.GH19897@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 05:19:04PM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch series adds support to configure the rate and enable the
> event stream for architected timer. The event streams can be used to
> impose a timeout on a wfe, to safeguard against any programming error
> in case an expected event is not generated or even to implement
> wfe-based timeouts for userspace locking implementations. This feature
> can be disabled(enabled by default).

I had two minor comments. Once they are addressed:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
