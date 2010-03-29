From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 29 Mar 2010 16:08:12 +0900
Subject: [QUERY] Any update on ARM PL080 DMA driver?
In-Reply-To: <4BB04C45.2060606@st.com>
References: <4BB04C45.2060606@st.com>
Message-ID: <1b68c6791003290008k655a3748v3f594280c421325a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 3:44 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>
> Is any body currently working on inclusion of PL080 DMA driver in linux?
> If yes, when will it be released?
It is already implemented for S3C64XX platform. grep for pl080_lli in ur tree.

There are some concerns like how to have a code that can be used by
other platforms as well and generic DMA i/f.

Perhaps we need to segregate S3C64xx into PL080 core driver and S3C64XX
DMA API driver. That is what I am planning to do with PL330. If the approach is
accepted, I plan move on to do the same with PL080.
