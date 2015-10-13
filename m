From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Oct 2015 10:59:35 -0700
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <20151009233148.GA31997@earth>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-2-git-send-email-eric@anholt.net>
 <20151009233148.GA31997@earth>
Message-ID: <87oag23b08.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Reichel <sre@kernel.org> writes:

> Hi,
>
> On Fri, Oct 09, 2015 at 02:27:42PM -0700, Eric Anholt wrote:
>> VC4 is the GPU (display and 3D) subsystem present on the 2835 and some
>> other Broadcom SoCs.
>> 
>> This binding follows the model of msm, imx, sti, and others, where
>> there is a subsystem node for the whole GPU, with nodes for the
>> individual HW components within it.
>
> I think it would be useful to have the acronyms written out one time
> in the document (VC4, HVS).

Done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/38207e89/attachment.sig>
