From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 12:26:08 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <CAMuHMdVi+6TXH68ddQ-UWfUif0Mv=ETu6dnpiy1Apike6zfAbg@mail.gmail.com>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <9935938.eKOCvCAtLt@fb07-iapwap2> <20140912083348.GA1289@katana>
 <7627175.tG5quZH0VN@fb07-iapwap2> <20140912095821.GB1930@katana>
 <CAMuHMdVi+6TXH68ddQ-UWfUif0Mv=ETu6dnpiy1Apike6zfAbg@mail.gmail.com>
Message-ID: <20140912102607.GC1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > DT pseudocode:
> >
> >         i2c {
> >                 compatible = "nvidia, tegra-i2c";
> >
> >                 ec-slave at 42 {
> >                         compatible = "nvidia, ax100-ec-slave";
> >                         reg = <0x42>;
> >                 };
> >         };
> 
> So distinguishing between drivers providing slave services (using slave
> mode) and drivers driving actual slave hardware (using master mode) is
> done based on the compatible-property.

We describe users of one specific I2C bus. And the drivers that go along
with them. No?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/411a8946/attachment.sig>
