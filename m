From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 16:37:13 +0530
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <9956925.Qsz2bH3rDg@vostro.rjw.lan>
References: <20140521073457.GD31687@pengutronix.de>
 <00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
 <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
 <9956925.Qsz2bH3rDg@vostro.rjw.lan>
Message-ID: <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I agree as far as the 64-bit thing goes, but is switching to Hz really
> necessary?

Don't really know that.. It seems that there will always be problems with
close enough frequencies whenever rounding is done.

More can be elaborated by Soren.
