From: rientjes@google.com (David Rientjes)
Date: Tue, 28 Jan 2014 23:29:10 -0800 (PST)
Subject: [PATCH] clk: export __clk_get_hw for re-use in others
In-Reply-To: <CAEjAshrxXLJ-zFsTO9TnewYBBEPzFR1cixbLnD6U-U1EKdByxg@mail.gmail.com>
References: <1390110907-29918-1-git-send-email-sj38.park@gmail.com>
 <20140119173712.GA26481@kroah.com>
 <CAPtuhTikj38yKy-=uF7O+VFG_N4AWee23f9woemM318fM3V4VQ@mail.gmail.com>
 <CAEjAshoh5ucPJA6pG1sx+7HGCYjHzCKtbzmH+GYJwpefDYLwJg@mail.gmail.com>
 <CAEjAshozB4S0ZGqEn41ROfZwGTV+_GZRRTZ8cssi0VdH8Uhr_w@mail.gmail.com>
 <20140122045937.GB23869@kroah.com>
 <CAEjAshrxXLJ-zFsTO9TnewYBBEPzFR1cixbLnD6U-U1EKdByxg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1401282328360.10321@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jan 2014, SeongJae Park wrote:

> Oops, I've forgot about the merge window. Thank you very much for your
> kind answer.
> Sorry if I bothered you while you're in busy time.
> Because the build problem is not a big deal because it exists only in
> -next tree,

This problem exists in Linus's tree, not only in -next.
