From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Jan 2015 16:05:15 +0100
Subject: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
In-Reply-To: <1421387408.9323.10.camel@mtksdaap41>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
Message-ID: <20150119150514.GB3820@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	struct i2c_adapter_quirks *quirks;
> >  };
> >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> >  
> 
> I suggest to add const.
> 	const struct i2c_adapter_quirks *quirks;
> 
> also, in i2c-core.c, should modify:
> 	const struct i2c_adapter_quirks *q = adap->quirks;

Thanks, I'll think about it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/9d6985ab/attachment-0001.sig>
