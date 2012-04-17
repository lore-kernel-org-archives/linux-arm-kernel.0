From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 13:59:48 +0530
Subject: Pinctrl crash on latest linux-next/master
In-Reply-To: <20120416140543.GC17173@shlinux2.ap.freescale.net>
References: <4F8BFA3F.5030409@st.com>
 <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
 <20120416140543.GC17173@shlinux2.ap.freescale.net>
Message-ID: <4F8D29FC.2010906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2012 7:35 PM, Dong Aisheng wrote:
>>> > > I don't know if the issue is in my patches or something else, but i was
>>> > > able to boot it earlier. Till my V3 for pinctrl. And nothing much changed
>>> > > since then, i just rebased on latest kernel.
>> > 
>> > Hm I haven't tested the pinctrl tree on v3.4-rc3 yet.
>> > 
> Your for-next tree is ok since i'm working on it for pinctrl-imx driver. :-)
> It seems it's based on v3.4-rc2.

At last, found it. It was my code :(
I was writing on more memory than was allocated to me.

Thanks for your inputs.

-- 
viresh
