From: alexander@alemayhu.com (Alexander Alemayhu)
Date: Tue, 13 Jun 2017 00:45:45 +0200
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <CAHgaXd+DW2bggto=2S9hOdMrtPTvhD2QN4rPf2V8iHewQpg-YA@mail.gmail.com>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
 <CAGXu5jKmLNMR+uhM9Ov2XPW6kCjip_SjScgEH0fTFp6fQtKFiA@mail.gmail.com>
 <593E6B0F.8070901@iogearbox.net>
 <CAHgaXd+DW2bggto=2S9hOdMrtPTvhD2QN4rPf2V8iHewQpg-YA@mail.gmail.com>
Message-ID: <20170612224545.GA25584@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 09:10:07PM +0530, Shubham Bansal wrote:
> 
> Nope. It looks like a latest addition to testing. Can you please tell
> me how to test with it?
>
cd tools/testing/selftests/bpf/
make
sudo ./test_progs

-- 
Mit freundlichen Gr??en

Alexander Alemayhu
