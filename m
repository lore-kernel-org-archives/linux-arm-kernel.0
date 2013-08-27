From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Aug 2013 10:29:07 -0700
Subject: [PATCH v2] arm: prima2: move to generic reset controller driver
 framework
In-Reply-To: <CAGsJ_4wZX5Tj92T1q=QcNNk+YhjQ0VLt8zQ9Vepy539GPRuF-Q@mail.gmail.com>
References: <1375175159-13953-1-git-send-email-Baohua.Song@csr.com>
 <CAGsJ_4wZX5Tj92T1q=QcNNk+YhjQ0VLt8zQ9Vepy539GPRuF-Q@mail.gmail.com>
Message-ID: <20130827172907.GC22852@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:36:14PM +0800, Barry Song wrote:
> 2013/7/30 Barry Song <21cnbao@gmail.com>:
> > this moves to generic IP module reset framework, and make other drivers
> > use common device_reset() API.
> >
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 
> Oolf, do you want to comment on it more, or apply it manually, or want
> me to send a pull request?

Hi,

See my comments on the reset controller api pull request; there still seems to
be some discussion about how to implement it. So the api is not likely to be
ready until after 3.12.


-Olof
