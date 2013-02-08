From: geoff@infradead.org (Geoff Levand)
Date: Fri, 08 Feb 2013 09:04:19 -0800
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
References: <20130204200238.GA16718@enea.se>
 <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
Message-ID: <1360343059.2889.13.camel@clam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2013-02-08 at 17:31 +0100, Frederic Weisbecker wrote:
> 2013/2/4 Mats Liljegren <mats.liljegren@enea.com>:
> > I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture, and try it out on the PandaBoard. Initially this is for evaluating it, but if it looks promising I'd like to upstream this.
> 
> Yeah two people have been working on this. But it was several month
> ago and I haven't hear from them since then. I'm adding Geoff in Cc. I
> can't retrieve the other guy who has worked on it too.

I haven't kept the patches up to date, but what I have is here:

  http://git.kernel.org/?p=linux/kernel/git/geoff/nohz.git

I have some Panda specific debugging patches in there too.  The
last version that worked OK with Panda was cpuset-v3-arm.  The
HEAD of the master branch had some problems at startup which I
never had a chance to fix.

-Geoff
