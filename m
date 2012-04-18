From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 18 Apr 2012 13:45:42 -0700
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <201204171434.06178.arnd@arndb.de>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <201204171434.06178.arnd@arndb.de>
Message-ID: <CAJOA=zNnZXdEwdswj31WHDoWjvRGz0fYUb99R0U=Qq9kX0EZHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 7:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 17 April 2012, Viresh Kumar wrote:
>> SPEAr now supports common clock framework. This patchset contains changes
>> related to this. It also contain few dependency commits for clock framework that
>> are earlier sent separately.
>>
>> @Mike: It would be easiest to get these through ARM-SoC tree. So, would need
>> your Acked-by on these patches. But firstly they must get reivewed :)
>
> We should agree on how we want to do the common clk patches for v3.5.
> The two options I see are either we take all the patches that Mike
> Acks into arm-soc, or Mike applies the patches in his own tree and
> submits them to arm-soc. I think either way is fine for me, but
> some people might feel strongly one way or another.

I would prefer the latter (I maintain a branch and submit it).  Is
arm-soc still the right place for common clk patches in 3.5 and
beyond?  I don't mind hosting a branch for inclusion into linux-next
and sending a pull request to Linus.  There is nothing ARM-specific
about the common framework.

Regards,
Mike
