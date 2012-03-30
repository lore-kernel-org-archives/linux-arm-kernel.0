From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 30 Mar 2012 10:45:19 +0530
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <CACRpkdaJpy_iRg4XzJepn=5tXLxBeYq3aMk1M_Z7WLD1+gw8iA@mail.gmail.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org>	<4F753007.2030707@st.com>
 <CACRpkdYaJ8sH0u6VTiaiPOJJ-D0pDo5oONyFXA4EvtL+WXEtjw@mail.gmail.com>
 <4F753FF3.4040704@st.com>
 <CACRpkdaJpy_iRg4XzJepn=5tXLxBeYq3aMk1M_Z7WLD1+gw8iA@mail.gmail.com>
Message-ID: <4F754167.4040405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/30/2012 10:44 AM, Linus Walleij wrote:
> get_groups_count() may make some sense if the number of
> available groups could in some instance change at runtime.
> Maybe a bit overcautious and pedantic but you never know...

Will go with get_groups_count(); :)

-- 
viresh
