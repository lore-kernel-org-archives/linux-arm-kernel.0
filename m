From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 11 Apr 2012 10:55:50 -0700
Subject: [PATCH] ARM: msm: remove unused MSM boards
In-Reply-To: <1334165870-12487-1-git-send-email-davidb@codeaurora.org>
References: <1334165870-12487-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20120411175550.GB8114@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:37:50AM -0700, David Brown wrote:
> The "mahimahi" and "sapphire" were never finished, and have never been
> built.
> 
> The "halibut" target was a dev board that hasn't ever been widely
> available (MSM7201 "SURF").


I don't mind if you remove halibut, but the others are just incomplete
phone support which someone may want to add to.. I'd prefer to fix those
two..

Daniel
