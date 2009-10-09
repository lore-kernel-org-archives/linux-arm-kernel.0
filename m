From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri, 09 Oct 2009 14:48:00 +0100
Subject: [PATCH] ARM: unexport symbols used to implement floating point
	emulation
Message-ID: <4ACF3F10.9040907@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Same deal as before - I'd like to have your Acked-by on this patch so I
can submit it as part of a series to Rusty.   It should be the last
ARM-specific issue, although I haven't finished the series yet so I
could be wrong.

This time I removed the the offending feature, since it appears unused. 
I'm hoping you can confirm this :-).

While I was looking, I found a few other cleanup opportunities.  They're
independent from my needs, so I'll submit them separately for inclusion
in the ARM tree.

Thanks
Alan

-------------------------------->
