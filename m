From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 19 Aug 2013 17:36:14 +0800
Subject: [PATCH v2] arm: prima2: move to generic reset controller driver
 framework
In-Reply-To: <1375175159-13953-1-git-send-email-Baohua.Song@csr.com>
References: <1375175159-13953-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CAGsJ_4wZX5Tj92T1q=QcNNk+YhjQ0VLt8zQ9Vepy539GPRuF-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/30 Barry Song <21cnbao@gmail.com>:
> this moves to generic IP module reset framework, and make other drivers
> use common device_reset() API.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Oolf, do you want to comment on it more, or apply it manually, or want
me to send a pull request?

-barry
