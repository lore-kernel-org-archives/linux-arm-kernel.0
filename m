From: davidb@codeaurora.org (David Brown)
Date: Tue, 15 May 2012 08:15:04 -0700
Subject: [PATCH v2] arm: msm: fix up very basic HTC Sapphire support
In-Reply-To: <CAPDArRKgZKR2kdbt-ySx7GrXopNnN+j4hKr1rrDPgxkZ8S2YjQ@mail.gmail.com>
References: <q7bdy899mt3um93hikst04au.1336884464056@email.android.com>
 <20120513055612.GA7129@codeaurora.org>
 <CAPDArRKgZKR2kdbt-ySx7GrXopNnN+j4hKr1rrDPgxkZ8S2YjQ@mail.gmail.com>
Message-ID: <20120515151504.GA2227@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 03:49:00PM +0530, Shantanu Gupta wrote:

> Sorry for thread jacking, but do you still have an actively supported
> 8x50 board ? ( ie. mahimahi)

I still have a working 8x50 dev board (SURF), but I don't use it very
much, but I do test it occasionally.  None of my 8x50 phone-type
devices work any more.  It doesn't look like the mahimahi code has
ever been compiled, though.

If no one objects, I'll just send out a patch to remove the
board-mahimahi.c file, since nothing references it, and it doesn't
have very useful support, anyway.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
