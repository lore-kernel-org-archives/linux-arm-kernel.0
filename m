From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 02 Mar 2010 21:36:23 -0600
Subject: board/device file names, and machine names
In-Reply-To: <a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
Message-ID: <4B8DD937.40301@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Swetland wrote:
> We would, of course, prefer to keep the board named mahimahi for all
> the reasons that have been mentioned in various previous discussions
> around trout, etc:
>   

Ooh, division in the camp.  :)

Actually, I'd like to change my previous answer.  In the interest of
getting code into kernel.org more quickly, I for one could live with
"mahimahi"--- so long as a comment in board-mahimahi.c provided the
"also-known-as" names.  Same for board-halibut.c, etc.

The point is to document the mapping between the various names
_somewhere_ within the kernel code itself.  Given that, LXR et. al can
help sort things out.  I'd prefer the mapping be done with filenames,
but mapping in comments is just about as good--- and probably more
flexible if a "mahimahi clone" ever appears: no need for another
filename, just add to the "also known as" comment.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
