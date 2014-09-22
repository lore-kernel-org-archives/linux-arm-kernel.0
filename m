From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 22 Sep 2014 17:26:38 +0200
Subject: [PATCH v5 4/9] rtc: at91sam9: add DT support
In-Reply-To: <20140922151754.GH5237@localhost>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-5-git-send-email-boris.brezillon@free-electrons.com>
 <20140922151754.GH5237@localhost>
Message-ID: <20140922172638.1c699ec9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Sep 2014 17:17:54 +0200
Johan Hovold <johan@kernel.org> wrote:

> [ Please don't drop people from CC. ]
> 
> On Mon, Sep 22, 2014 at 11:10:53AM +0200, Boris BREZILLON wrote:
> > Add of_match_table to the existing driver so that rtc nodes defined in at91
> > DTs can be attached to this driver.
> 
> That should be rtt nodes.

Oh crap! Hopefully this is the last occurrence of 'rtc' in my commit logs :-).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
