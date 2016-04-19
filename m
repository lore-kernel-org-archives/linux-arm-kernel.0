From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 19 Apr 2016 10:41:45 +0200
Subject: [RESEND PATCH v2 0/2] rockchip: power-domain: support qos save
 and restore
In-Reply-To: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
References: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3149623.GO2tq37NbT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. April 2016, 14:20:18 schrieb Elaine Zhang:
> add qos document in dt-bingings.
> modify power domain driver to support qos save and restore.
> 
> Changes in v2:
> [PATCH V2 1/2]: fix up the commit message.
> [PATCH V2 2/2]: add some error handling.
> 		fix up the define and request space for qos_regmap and qos_save_regs.
> 
> Elaine Zhang (2):
>   dt-bindings: modify document of Rockchip power domains
>   rockchip: power-domain: support qos save and restore

applied both to my drivers branch for 4.7


Thanks
Heiko
