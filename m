From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Oct 2009 21:50:41 +0800
Subject: Problem in booting off a pxa270 board
In-Reply-To: <967093cd0910070453m28edef9v9127d271d20fbd76@mail.gmail.com>
References: <967093cd0910070357w2c603fefn5ea386f6c6c757e5@mail.gmail.com>
	<967093cd0910070453m28edef9v9127d271d20fbd76@mail.gmail.com>
Message-ID: <f17812d70910080650t246ca8cdy2639fcc0fef5e156@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2009 at 7:53 PM, Saurabh Kadekodi
<saurabhkadekodi@gmail.com> wrote:
> Hi All,
>
> I have pxa270 based board, and I've just recently put an
> emdebian-crush root filesystem image on it. On booting the board I get
> upto the point where it starts init and then it fails for some
> subsequent processes.
>
> I would be grateful if someone could enlighten why this could be happening.
>

Can you just pass init=/bin/sh to drop yourself into a shell and run syslogd
as what's in the rcS? There were cases that command in busybox accepts
different options as in its standard version.
