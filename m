From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 2 Apr 2014 19:38:33 -0300
Subject: mx27 running too slow
In-Reply-To: <CAOMZO5CC1NwP14H7uuygX7ZviFJLriG41hyczzvzxYWKHJu5DQ@mail.gmail.com>
References: <CAOMZO5CC1NwP14H7uuygX7ZviFJLriG41hyczzvzxYWKHJu5DQ@mail.gmail.com>
Message-ID: <CAOMZO5AUemi9r_NqXXpnYZUqbqHhYnSvrnmu11voM_MZsVUa6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 7:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Alexander,
>
> What is the BogoMIPs value you get on mx27 running 3.14?
>
> I am running Shawn's for-next branch and it is terribly slow on a mx27pdk:
>
> sched_clock: 32 bits at 13MHz, resolution 75ns, wraps every 322929872820ns
> CPU identified as i.MX27, silicon rev 2.1
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer
> frequency.. 26.60 BogoMIPS (lpj=133000)
>
> ARM9 running at 400MHz should give around 200 BogoMIPs.

Nevermind. On a clean 3.14 kernel I get the expected value:

Calibrating delay loop... 199.06 BogoMIPS (lpj=995328)

So this behaviour shows up only on Shawn's branch.

Regards,

Fabio Estevam
