From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Sep 2016 17:18:29 +0100
Subject: [PATCH] arm64: kprobe: Always clear pstate.D in breakpoint
 exception handler
In-Reply-To: <CAHB_Guods-iED+tOLeJ9XCWDvAVoButwz2XWSiP+eMYDzFhfyQ@mail.gmail.com>
References: <1059f6762466c2cebf32aa40e4d7974731a68726.1471848065.git.panand@redhat.com>
 <20160823000531.b12ac14c18ce8e9d3abc74ec@kernel.org>
 <CAAOGbpwcx3G8Jdf1AfNRLrkZJQLaCcLWQPRppjvpy3=hSrffjg@mail.gmail.com>
 <20160824100644.GB4408@localhost.localdomain>
 <CAHB_Guods-iED+tOLeJ9XCWDvAVoButwz2XWSiP+eMYDzFhfyQ@mail.gmail.com>
Message-ID: <20160915161828.GH3380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 09:45:09PM +0530, Pratyush Anand wrote:
> On Wed, Aug 24, 2016 at 3:36 PM, Pratyush Anand <panand@redhat.com> wrote:
> > On 23/08/2016:04:33:08 PM, Sandeepa Prabhu wrote:
> >> Thanks for the fix, feel free to add my ACK as well. Has it been tested on
> >> guest kernel?
> >
> > have not tested on guest kernel.Will do.
> 
> I tested it with guest kernel, and it worked there too :-).
> 
> @Catalin: any more comment for this patch? If not, then may be you can take it.

I already queued this on the arm64 for-next/core branch.

Will
