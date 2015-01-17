From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 17 Jan 2015 02:26:25 +0100
Subject: [PATCH v2 1/2] clocksource: track usage
In-Reply-To: <CALAqxLUwRirmeZD-ggbq0ryTi4vrT5w3Drfzg3zLxXnmrurOJg@mail.gmail.com>
References: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421427439-11699-2-git-send-email-alexandre.belloni@free-electrons.com>
 <CALAqxLUwRirmeZD-ggbq0ryTi4vrT5w3Drfzg3zLxXnmrurOJg@mail.gmail.com>
Message-ID: <20150117012625.GU3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/01/2015 at 11:05:46 -0800, John Stultz wrote :
> On Fri, Jan 16, 2015 at 8:57 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Track whether the clocksource is enabled or disabled.
> 
> 
> So.. this commit message needs work. Why do we care to track the
> clocksource enabled/disabled state?
> 

What about:

Track whether the clocksource is enabled or disabled. This will allow to
select whether an action is necessary, for example suspend or resume.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
