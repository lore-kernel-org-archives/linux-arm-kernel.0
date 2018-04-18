From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Wed, 18 Apr 2018 09:38:12 +0200
Subject: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
 <2284833.pBtR1QS54F@bentobox>
 <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
Message-ID: <2715737.hC3rduhfyA@bentobox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mittwoch, 18. April 2018 12:45:20 CEST Sricharan R wrote:
>  Right, will add the above change to soc.dtsi in V6. Does that sound ok for 
> you ?

I have submitted a patch for this now [1] because I need this for OpenWrt 
(sooner rather than later). And I am not sure whether it is good to have this 
in your feature series because it is a bugfix which might even qualify for 
stable at vger.kernel.org.

I hope this patch [1] is ok for you.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/10347459/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/c909b9e2/attachment.sig>
