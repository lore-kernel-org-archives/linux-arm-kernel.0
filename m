From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 8 Jul 2010 10:31:47 -0700
Subject: [PATCH] s5pc110: Reduce the iodesc length of systimer
In-Reply-To: <AANLkTilA5_kKf_CYE98ul1znzF1AT_mektC2TrFd9vyv@mail.gmail.com>
References: <20100708023647.GA8320@july>
	<020201cb1e8d$7d90ba50$78b22ef0$%kim@samsung.com>
	<AANLkTilA5_kKf_CYE98ul1znzF1AT_mektC2TrFd9vyv@mail.gmail.com>
Message-ID: <20100708103147.b2e30323.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jul 2010 20:40:39 +0900 Kyungmin Park <kmpark@infradead.org> wrote:

> Can you explain Mr. Kim request?
> As your suggestion, If the sender and signed-off are different, add
> the From filed at body.
> 
> I think no need to add duplicated signed-off since it's same person.

If you're sending a patch which someone else wrote then at a minimum it
should have that person's From: at the top of the changelog and it
should have your Signed-off-by:.



However it is not required that the patch have the author's
Signed-off-by:.  See Documentation/SubmittingPatches, section 12.  If
you sent the patch and signed it then _you_ assert that it's OK to
include the patch in Linux.

That being said, we do prefer that both the author and the sender
include their signoffs.
