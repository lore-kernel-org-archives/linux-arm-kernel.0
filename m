From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 8 May 2017 14:28:13 +0200
Subject: [PATCH v7 15/24] KVM: arm64: vgic-its: Read config and pending
 bit in add_lpi()
In-Reply-To: <1494084283-12723-16-git-send-email-eric.auger@redhat.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-16-git-send-email-eric.auger@redhat.com>
Message-ID: <20170508122813.GG28342@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 05:24:34PM +0200, Eric Auger wrote:
> When creating the lpi we now ask the redistributor what is the state
> of the LPI (priority, enabled, pending).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 

Reviewed-by: Christoffer Dall <cdall@linaro.org>
