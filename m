From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 30 Apr 2014 13:03:51 -0300
Subject: [PATCH for v3.15] net: mvmdio: Check for a valid interrupt
 instead of an error
In-Reply-To: <5360FA35.7070209@gmail.com>
References: <1398800999-9814-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <53601B96.3000608@gmail.com> <20140430114209.GA1907@arch.cereza>
 <5360FA35.7070209@gmail.com>
Message-ID: <20140430160351.GA17162@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 30, Sebastian Hesselbarth wrote:
> 
> As we know about the potential -EPROBE_DEFER now, I suggest to
> deal with it now, too.
> 
> Can you resend this as v2 with the other patch you mentioned
> squashed in?
> 

Sure. I did that first, but then wasn't sure about squashing both changes.

Thanks for helping out,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
