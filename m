From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 27 Jan 2015 01:38:00 +0100
Subject: [PATCH 1/2] ARM: zynq: Remove bogus value from 'bias-disable'
 property
In-Reply-To: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <54C6DDE8.3000905@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.01.2015 um 20:49 schrieb Soren Brinkmann:
> In one pinctrl node, a 'bias-disable' property is erroneously assigned a
> value.
> 
> Fixes: ARM: zynq: DT: Add pinctrl information
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/730c82d3/attachment.sig>
