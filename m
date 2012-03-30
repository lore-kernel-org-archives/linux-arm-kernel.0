From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 30 Mar 2012 10:39:07 +0530
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <CACRpkdYaJ8sH0u6VTiaiPOJJ-D0pDo5oONyFXA4EvtL+WXEtjw@mail.gmail.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org>	<4F753007.2030707@st.com>
 <CACRpkdYaJ8sH0u6VTiaiPOJJ-D0pDo5oONyFXA4EvtL+WXEtjw@mail.gmail.com>
Message-ID: <4F753FF3.4040704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/30/2012 10:34 AM, Linus Walleij wrote:
> Just patch it, as detailed in the other letter there is really no point
> for having it like this so go ahead. As long as you also patch all
> the users and remove the old interface, just rewrite it.

I have this in mind. Will fix all users.

> If you could also test it on something it'd be nice ...

I don't have any board to test it. But after i am done with this, i
will complete pinctrl support for SPEAr and there i can test it.

I hope before that lot of other people would be able to test it. :)

BTW, i am planning not to add another call, get_groups_count(),
but add another field like ngroups, which would be set by users.

-- 
viresh
