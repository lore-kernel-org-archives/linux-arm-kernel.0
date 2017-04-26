From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 26 Apr 2017 09:48:33 +0530
Subject: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
In-Reply-To: <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
References: <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7>
 <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7>
 <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7>
 <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
 <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com>
 <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com>
 <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
Message-ID: <20170426041833.GD1928@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-04-17, 12:24, Fabio Estevam wrote:
> On Tue, Apr 25, 2017 at 11:35 AM, Adam Ford <aford173@gmail.com> wrote:
> 
> > I have a touch screen (using tsc2004 touch controller) on my board.  I
> > can run some tests if you tell me how you're able to reproduce your
> > issue.  I can at least confirm whether or not I see it too.  I won't
> > be able to do it until later tonight or tomorrow however.
> 
> Just run:
> 
> evtest /dev/input/eventX to capture the touchscreen events and keep
> touching the screen.
> 
> After some random time (1-2 minutes) evtest will stop capturing the events.

And set the governor to Powersave to make sure we are running on
lowest OPP.

-- 
viresh
