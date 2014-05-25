From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 16:35:15 +0100
Subject: [PATCH v2 6/9] arm64: KVM: check ordering of all system register
 tables
In-Reply-To: <1400604945-25247-7-git-send-email-marc.zyngier@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525153515.GG3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:55:42PM +0100, Marc Zyngier wrote:
> We now have multiple tables for the various system registers
> we trap. Make sure we check the order of all of them, as it is
> critical that we get the order right (been there, done that...).
> 
> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
