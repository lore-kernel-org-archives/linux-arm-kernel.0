From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 13:24:35 +0000
Subject: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
Message-ID: <20130209132435.169133E30EC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  3 Feb 2013 01:29:29 +0900, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Make sure gpiolib works internally with descriptors and (chip, offset)
> pairs instead of using the global integer namespace. This prepares the
> ground for the removal of the global gpio_desc[] array and the
> introduction of the descriptor-based GPIO API.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Despite Linus' comments, I've gone ahead and applied this. I think it is
a worthwhile change on its own and it feeds into the future work than
needs to be done. Any of the stuff he brought up can be addressed in
follow-on patches.

g.
