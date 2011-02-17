From: vb@vsbe.com (vb at vsbe.com)
Date: Thu, 17 Feb 2011 15:23:54 -0800
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
	<AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
	<AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
	<AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
Message-ID: <AANLkTinrqUkMa2+1DXT4+GNxbzYA-ubQiJHBDA2j1Gjp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 9:30 AM,  <vb@vsbe.com> wrote:
>
> It looks like certain files need to be compiled in ARM mode even when
> THUMB2_KERNEL is enabled, but I don't see this happening in 2.6.37, I
> was wondering how this is done in your tree.
>

ah, I think I figured this part - there is an assembler directive .arm
which overrides the command line specified mode (ARM vs THUMB)

cheers,
/v
