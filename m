From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 17 Dec 2012 12:43:46 +0000
Subject: [PATCH] arm: vexpress: hook platform_data to clcd_pl11x by amba
 bus_notify
In-Reply-To: <CAGsJ_4wiYWe9YcQx_H5bmMtAsV=V9em6n8bKXxnb29CisK_WiA@mail.gmail.com>
References: <1355549964-12893-1-git-send-email-21cnbao@gmail.com>
 <1355747549.2978.5.camel@hornet>
 <CAGsJ_4wiYWe9YcQx_H5bmMtAsV=V9em6n8bKXxnb29CisK_WiA@mail.gmail.com>
Message-ID: <1355748226.2978.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-17 at 12:39 +0000, Barry Song wrote:
> > Now having said all that, I'm hoping to get comprehensive solution for
> > DT-based VE display devices ready in time for 3.9, which will sort out
> > the issue once for all.
> 
> well, look forward to see that. but as i said, i will use 3.7 for
> these monthes, booting your board by dt and hope to back port yours to
> my 3.7 later.

Sure thing, if this works for you. You may also want to have a look at
the Linaro VE releases, as they have working (if slightly baroque ;-) DT
solution for CLCD as well.

Thanks!

Pawe?
