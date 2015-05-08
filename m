From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 May 2015 12:19:40 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150507213015.GB2455@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <CAKohpomYQw67KuX29PLawmd1dSXHx7pMt7+8BzmLPfHSqhMB2g@mail.gmail.com>
 <20150507213015.GB2455@codeaurora.org>
Message-ID: <CAKohpo=Eq=Eno6PThDkNFm_tDKv47mTPWhjb_JHPs7+78x3Q-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 03:00, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/07, Viresh Kumar wrote:

>> - Now if uV is fixed, how is the target current controlled separately ?
>
> uV is not fixed

I meant uV is fixed for this particular OPP, i.e. min/tar/max value.


What about the other changes? Does these fix the use cases you shared
earlier ? I will send a new updated version then..
