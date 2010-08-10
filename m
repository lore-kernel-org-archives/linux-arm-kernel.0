From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed, 11 Aug 2010 01:04:08 +0300
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C5F9B25.8080401@st.com>
References: <4C5F9B25.8080401@st.com>
Message-ID: <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 9, 2010 at 9:07 AM, viresh kumar <viresh.kumar@st.com> wrote:
> Mail server in ST has recently changed and now we have Microsoft
> exchange server. We are using thunderbird as mail client.
> What we observed with this server is that patch are broken now while
> sending as well as receiving. Tabs are replaced by spaces and may
> be some other too which we haven't observed.
>
> Has anybody found a solution to this kind of issues? Are there any
> workarounds possible?

Same in Nokia. I wrote a script to fix exchange's crap, but I also
noticed some quoted-printable mails didn't get converted, so the
easiest would be to tell git to always send quoted-printable.

git folks: any chance of getting that feature to git send-email?

-- 
Felipe Contreras
