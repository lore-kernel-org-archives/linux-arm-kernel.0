From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 11:44:50 +0000
Subject: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
 <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
Message-ID: <20170104114449.GA18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 03:25:53PM -0800, Laura Abbott wrote:
> On 01/03/2017 02:56 PM, Florian Fainelli wrote:
> > On 01/03/2017 09:21 AM, Laura Abbott wrote:
> >> Happy New Year!
> >>
> >> This is a very minor rebase from v5. It only moves a few headers around.
> >> I think this series should be ready to be queued up for 4.11.
> > 
> > FWIW:
> > 
> > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> 
> Thanks!
> 
> > How do we get this series included? I would like to get the ARM 32-bit
> > counterpart included as well (will resubmit rebased shortly), but I have
> > no clue which tree this should be going through.
> > 
> 
> I was assuming this would go through the arm64 tree unless Catalin/Will
> have an objection to that.

Yup, I was planning to pick it up for 4.11.

Florian -- does your series depend on this? If so, then I'll need to
co-ordinate with Russell (probably via a shared branch that we both pull)
if you're aiming for 4.11 too.

Will
