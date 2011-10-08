From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 8 Oct 2011 13:31:41 +0200
Subject: [PATCH 24/26] ARM: pxa: centro and treo680 need palm27x
In-Reply-To: <CAMPhdO9hTC0_30Oxc+ndn5EstOEMQKa7E_MEf4jn7ipTBbhBfw@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-25-git-send-email-arnd@arndb.de>
	<CAMPhdO9hTC0_30Oxc+ndn5EstOEMQKa7E_MEf4jn7ipTBbhBfw@mail.gmail.com>
Message-ID: <201110081331.41414.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 08, 2011 12:20:57 PM Eric Miao wrote:
> On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The two platforms are part of the palm27x family and use the same
> > code. Select the palm27x symbol to make sure they can be built
> > standalone.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Applied.

Thanks Eric.
