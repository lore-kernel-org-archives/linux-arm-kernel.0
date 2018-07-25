From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 25 Jul 2018 09:13:57 +0000
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
In-Reply-To: <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
Message-ID: <CY1PR02MB16921C8D66930128BAF104B4DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

	Thanks for the review...

<Snip> 
> Another minor thing.
> 
> > +
> >
> +/**************************************************************
> ******
> > +********/
> 
> Let's keep the coding style consistent by not having

Sure will fix in v4...

> '***************************'
> 
> > +/**
> > + *
> 
> Also, you don't need /** followed by '*', just take out the essentially blank
> line here, please.

Sure will fix in v4...

Regards,
Kedar.

> 
> > + * Generates a Type 2 packet header that reads back the requested
> > +Configuration
> > + * register.
> > + *
> > + * @param        OpCode is the read/write operation code.
> > + * @param        Size is the size of the word to be read.
> > + *
> > + * @return       Type 2 packet header to read the specified register
> > + *
> > + * @note         None.
> > + *
> > +
> >
> +***************************************************************
> ******
> > +********/ static int zynq_type2_pkt(u8 OpCode, u32 Size) {
> 
> Thanks,
> Alan
