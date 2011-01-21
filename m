From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Fri, 21 Jan 2011 15:40:55 -0200
Subject: [PATCH] fix perf Annotation of Thumb code
In-Reply-To: <4D39BF9E.3030007@ru.mvista.com>
References: <20110121163922.GA31398@davesworkthinkpad>
	<4D39BF9E.3030007@ru.mvista.com>
Message-ID: <20110121174055.GD15066@ghostprotocols.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jan 21, 2011 at 08:17:18PM +0300, Sergei Shtylyov escreveu:
> >(For reference this corresponds to this bug
> >https://bugs.launchpad.net/linux-linaro/+bug/677547 )
> 
> >        Signed-off-by: Dr. David Alan Gilbert <david.gilbert@linaro.org>
> 
>    Hm, I think there should be no spaces/tabs before signoff...
> 
> >+			sym.st_value-=1;
> 
>   The coding style used suggests spaces around -=.
> 
> WBR, Sergei

I noticed both issues and will fix them up when applying the patch.

Thanks

- Arnaldo
