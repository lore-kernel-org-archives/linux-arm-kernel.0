From: mats.liljegren@enea.com (Mats Liljegren)
Date: Mon, 4 Feb 2013 21:02:39 +0100
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
Message-ID: <20130204200238.GA16718@enea.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frederic,

(Sorry for the re-post, I spelled the mailing list wrong...)

I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture, and try it out on the PandaBoard. Initially this is for evaluating it, but if it looks promising I'd like to upstream this.

As far as I can see the first thing to do is to implement virtual time accounting. After an initial look at the patches done for ia64, it doesn't look too difficult.

Are there any caveats I should be aware of?
Has anyone else started any work in this area that I could co-operate with?

Regards
Mats Liljegren
