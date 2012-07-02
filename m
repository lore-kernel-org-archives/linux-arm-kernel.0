From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Mon, 02 Jul 2012 14:30:57 +0200
Subject: [PATCH v3 3/5] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <CAKfTPtAHvKcdgiL4xx-zBJU5DZ5YwGUbjgtoh9a1tf_C2Amg5w@mail.gmail.com>
References: <1340205562-7653-1-git-send-email-vincent.guittot@linaro.org>
 <1340205562-7653-4-git-send-email-vincent.guittot@linaro.org>
 <1341220283.28750.138.camel@twins>
 <CAKfTPtAHvKcdgiL4xx-zBJU5DZ5YwGUbjgtoh9a1tf_C2Amg5w@mail.gmail.com>
Message-ID: <1341232257.23484.10.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-02 at 14:11 +0200, Vincent Guittot wrote:
> max / (min + max) * 2^11 so the cpu_scale is smaller than 2^11  as min
> is never equal to 0 

D'0h right.. I think I confused the middle thing with avg again. 
