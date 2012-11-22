From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 22 Nov 2012 12:23:28 +0200
Subject: Possible regression in arm/io.h
In-Reply-To: <20121122101915.GA3113@mudshark.cambridge.arm.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <CABYn4swp9JBEHgGTOkoe=tOh3Mf1dq5WYr=2xuKNpTmLX5LcFQ@mail.gmail.com>
 <20121024130957.GB7339@mudshark.cambridge.arm.com>
 <CABYn4sz4v7Uf07am=MtPAKAvvAjwt+-bTRaLrBjoiRuyR9cfZw@mail.gmail.com>
 <20121024135854.GD7339@mudshark.cambridge.arm.com>
 <CABYn4sxnwzj8KFfELzCLzQMcAjiqS3_Vr2kStkm-na8G1noPHA@mail.gmail.com>
 <20121024152730.GH7339@mudshark.cambridge.arm.com>
 <1353571055.2701.21.camel@sauron.fi.intel.com>
 <20121122101915.GA3113@mudshark.cambridge.arm.com>
Message-ID: <1353579808.2701.28.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-22 at 10:19 +0000, Will Deacon wrote:
> > Any progress with this? Do we end up with gcc 4.6+ - uncompilable MTD
> > drivers in 3.7?
> 
> I fixed it in 7629a9f661f7 ("ARM: 7567/1: io: avoid GCC's offsettable
> addressing modes for halfword accesses").

Ah, this is in v3.7-rc5, I am using -rc4 and this is why I did not
notice this. Thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/2e31cd37/attachment.sig>
