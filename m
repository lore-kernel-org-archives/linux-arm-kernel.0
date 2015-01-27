From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Jan 2015 14:40:54 -0500 (EST)
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150127132127.GA869@amd>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262016.52079@pali>
 <CAL_JsqL_EEg7tC-q8wV5v8jAfPSiri4z19iJfz2r7zntRwPyOg@mail.gmail.com>
 <20150127132127.GA869@amd>
Message-ID: <alpine.LFD.2.11.1501271439020.1322@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jan 2015, Pavel Machek wrote:

> On Mon 2015-01-26 14:33:21, Rob Herring wrote:
> > These would be non-standard fields which are not upstream. I don't
> > know that we care in that case...
> 
> Other devices are going to care about boot reason, too, and we might
> as well be compatible...

Care to elaborate on that statement please?  What does this have to do 
with ATAGs?


Nicolas
