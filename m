From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 7 Sep 2018 10:36:38 -0600
Subject: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
In-Reply-To: <MWHPR01MB2336534C2B5343D4235063E3B3000@MWHPR01MB2336.prod.exchangelabs.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
 <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
 <cd3e5c60-1619-9842-6198-e36fdbaa4b4b@kernel.dk>
 <MWHPR01MB2336534C2B5343D4235063E3B3000@MWHPR01MB2336.prod.exchangelabs.com>
Message-ID: <044a4fee-9d6d-371c-dc9d-a81e9512c3ba@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/18 10:35 AM, Suman Tripathi wrote:
>> I can apply it manually while you work out the kinks in your email
>> setup. It might even be your company MTA mangling it, I've seen all
>> sorts of crazy like that.
>
> Thanks for the support. We are working with IT to fix this issue.

Good luck! If all else fails, there's always gmail...

In any case, queued up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.20/libata&id=20bdc376b427cb420836f39ee8f281ea85dbaeef

-- 
Jens Axboe
