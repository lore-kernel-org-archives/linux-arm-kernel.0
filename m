From: damien.riegel.ext@parrot.com (Damien Riegel)
Date: Thu, 25 Jul 2013 15:20:41 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
References: <51E667BC.3070804@parrot.com>	<51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
Message-ID: <51F12629.7090909@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't know about pinctrl background but I don't really get why there
is such a distinction between gpio and other functions in most cases.

I understand that on some arch a pin can be muxed and used as a gpio at
the same time. But on most arch, isn't gpio just another function that
can be muxed on a pin, and therefore we should check that a pin can be
requested as a gpio just by checking desc->mux_owner ?
