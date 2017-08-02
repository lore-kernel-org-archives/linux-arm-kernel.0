From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 1 Aug 2017 18:08:50 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Specify USB ports for each controller
In-Reply-To: <20170627173527.16682-1-zajec5@gmail.com>
References: <20170627173527.16682-1-zajec5@gmail.com>
Message-ID: <7d0b069e-dbde-b601-e51e-ebef98f79847@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2017 10:35 AM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Northstar has 3 controllers: OHCI and EHCI (each with 2 ports) and XHCI
> (with just 1 port). Describe them in the DT. In future this will allow
> to reference them as trigger sources.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied, thanks! There must have been some kind of problem with your
email address as it appeared to have been banned from
bcm-kernel-feedback-list at broadcom.com (now fixed) which was not making
our internal patchwork pick up your patch.

Let me know if there are other submissions from you that I should apply.
Thanks!
-- 
Florian
