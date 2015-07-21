From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 21 Jul 2015 13:57:32 +0200
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <55AE0803.10603@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <4778199.vGjAP5lpOS@fb07-iapwap2> <55AE0803.10603@mail.ru>
Message-ID: <2107735.0gMPOtIgYc@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 11:51:15 schrieb Andrey Danin:
> On 21.07.2015 11:25, Marc Dietrich wrote:
> > I think in this case it would be better to leave nvec and dt as it is for
> > now, and just add the slave function to tegra-i2c. Otherwise we will
> > again have two different "nvidia,nvec-slave" bindings (one for the
> > intermediate hack and one for the final representation). As an
> > alternative, you could also add slave function and port nvec in the same
> > series.
> 
> First patch only adds slave functionality to tegra-i2c driver. I sent v3
> to fix only tegra-i2c as Wolfram suggested.
> 
> Unfortunately I haven't fixed all defects and I will resend patch(es).
> I can resend only first patch (for tegra-i2c) if it is more obvious for
> everyone.

It's up to you. I think if the NV guys are ok with the tegra i2c change, 
Wolfram can merge it right away for 4.3. Not sure about the state of the nvec 
changes though and if they can be ready soon.

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/2c59c159/attachment.sig>
