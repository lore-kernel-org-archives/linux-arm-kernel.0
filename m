From: panand@redhat.com (Pratyush Anand)
Date: Thu, 15 Sep 2016 21:45:09 +0530
Subject: [PATCH] arm64: kprobe: Always clear pstate.D in breakpoint
 exception handler
In-Reply-To: <20160824100644.GB4408@localhost.localdomain>
References: <1059f6762466c2cebf32aa40e4d7974731a68726.1471848065.git.panand@redhat.com>
 <20160823000531.b12ac14c18ce8e9d3abc74ec@kernel.org>
 <CAAOGbpwcx3G8Jdf1AfNRLrkZJQLaCcLWQPRppjvpy3=hSrffjg@mail.gmail.com>
 <20160824100644.GB4408@localhost.localdomain>
Message-ID: <CAHB_Guods-iED+tOLeJ9XCWDvAVoButwz2XWSiP+eMYDzFhfyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandeepa,


On Wed, Aug 24, 2016 at 3:36 PM, Pratyush Anand <panand@redhat.com> wrote:
> Hi Sandeepa,
>
> Thanks for the review.
>
> On 23/08/2016:04:33:08 PM, Sandeepa Prabhu wrote:
>> Thanks for the fix, feel free to add my ACK as well. Has it been tested on
>> guest kernel?
>
> have not tested on guest kernel.Will do.

I tested it with guest kernel, and it worked there too :-).

@Catalin: any more comment for this patch? If not, then may be you can take it.

~Pratyush
