From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 30 Nov 2011 08:22:42 -0800
Subject: [RFC V1 7/8] ARM i.MX: prepare common clk support
In-Reply-To: <20111130061815.GA8684@b20223-02.ap.freescale.net>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-8-git-send-email-richard.zhao@linaro.org>
 <CAPtuhTgSB8Af4Xtux93-VLXSrK5KkzFOez9V5tcmbkKwbZ_8Rw@mail.gmail.com>
 <20111129030944.GB19236@b20223-02.ap.freescale.net>
 <CAPtuhThNZA707gQhjt9-V_B8=5UN9o1JgNTm_Dj8eLO-WNmJQA@mail.gmail.com>
 <20111130061815.GA8684@b20223-02.ap.freescale.net>
Message-ID: <CAPtuhTij8rATJsbVxnxB-zey5Jj2nycNnM2iqBPKJFa8fnypAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 10:18 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> Do you mean you also adopt divider and mux clock patch?

I'd like to do that and roll them into the existing clk-basic.c.  Are
you OK with this approach?

Regards,
Mike
