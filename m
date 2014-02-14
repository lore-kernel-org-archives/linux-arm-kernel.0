From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 14 Feb 2014 16:05:02 +0200
Subject: [PATCH 6/8] ARM: dts: use ti,
 fixed-factor-clock for dpll4_m4x2_mul_ck
In-Reply-To: <52FE2001.1020906@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <1392285846-13199-7-git-send-email-tomi.valkeinen@ti.com>
 <52FE2001.1020906@ti.com>
Message-ID: <52FE228E.6050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/14 15:54, Tero Kristo wrote:
> On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
>> We need to use set-rate-parent for dpll4_m4 clock path, so use the
>> ti,fixed-factor-clock version which supports set-rate-parent property.
> 
> 
> .... you are talking about the flag but not introducing it in this
> patch, maybe squash this + patch 7...?

Hmm, yes, I should mention that the flag itself is set in a following patch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/bb600c28/attachment.sig>
