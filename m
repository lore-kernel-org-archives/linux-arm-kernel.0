From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 8 Dec 2015 17:34:14 -0300
Subject: [PATCH V6 00/26] Coresight integration with perf
In-Reply-To: <CANLsYkxaOpMcC8ULcTvC1tOd5yEcjH2ZiNS5Rp6UyodzNsAD1g@mail.gmail.com>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkxaOpMcC8ULcTvC1tOd5yEcjH2ZiNS5Rp6UyodzNsAD1g@mail.gmail.com>
Message-ID: <20151208203414.GN11564@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Dec 08, 2015 at 01:29:00PM -0700, Mathieu Poirier escreveu:
> On 3 December 2015 at 14:04, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> Arnaldo, Peter and Ingo,
> 
> I would like to queue this work for 4.5 but need your help with
> reviewing patches 20 [1], 23 [2], 24 [3], 25 [4] and 26 [5].
> 
> A "reviewed-by" would be greatly appreciated.

I looked briefly at it and saw perf_session, IIRc, being passed to more
functions, which I think can be done otherwise, as, again IIRC, all you
need is available via perf_evlist, will look again.

- Arnaldo
