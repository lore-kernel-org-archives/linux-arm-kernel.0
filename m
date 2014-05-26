From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 21:52:21 +0530
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <1401119853.4829.65.camel@weser.hi.pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
 <1401109863.4829.46.camel@weser.hi.pengutronix.de>
 <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
 <1401112697.4829.56.camel@weser.hi.pengutronix.de>
 <CAKohponvWLVfBL06HURnTq4nmdKjROV-bd4pVcbNmsAUYYC+nA@mail.gmail.com>
 <1401118115.4829.60.camel@weser.hi.pengutronix.de>
 <CAKohpo=yShVa+5On0cPU68ooQGO8dFXP+amPHf3taP_aYYe1Qg@mail.gmail.com>
 <1401119853.4829.65.camel@weser.hi.pengutronix.de>
Message-ID: <CAKohpo=0VoOEz=SmvU+m6rX3beJ_nMpCUCx504Hsw2jRj2_QSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 21:27, Lucas Stach <l.stach@pengutronix.de> wrote:
> No, we need the regulator to determine which OPPs are actually useable.
> If the regulator is only supplying 1.1V we can only scale to 800MHz max,
> which is the case for some of the industrial i.MX53 versions.

Go and add another binding for this max-volt.. And lets see how others
respond.

You can give a link to this discussion as others might find this very helpful.
