From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sat, 9 Feb 2013 23:18:03 +0900
Subject: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <20130209132435.169133E30EC@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
 <20130209132435.169133E30EC@localhost>
Message-ID: <CAAVeFuLP0Deyr4hzW_XYDbQ0qehYaNydTrQzRo+B8saEcNLOFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 9, 2013 at 10:24 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun,  3 Feb 2013 01:29:29 +0900, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> Make sure gpiolib works internally with descriptors and (chip, offset)
>> pairs instead of using the global integer namespace. This prepares the
>> ground for the removal of the global gpio_desc[] array and the
>> introduction of the descriptor-based GPIO API.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Despite Linus' comments, I've gone ahead and applied this. I think it is
> a worthwhile change on its own and it feeds into the future work than
> needs to be done. Any of the stuff he brought up can be addressed in
> follow-on patches.

Ah, I actually wanted to ask you for a couple of days to submit a new
version of this. On top of Linus' comments, there are a few more
sanity checks I'd like to add. If you don't want to rebase on the new
version, I can also send a new patch on top of this one, whichever way
you prefer - but I think rebasing would be cleaner, if you don't mind.

Alex.
