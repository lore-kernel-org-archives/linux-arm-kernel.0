From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 28 Nov 2014 07:58:52 +0530
Subject: [PATCH 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
In-Reply-To: <20141127140803.GA3342@developer>
References: <1417024212-1775-1-git-send-email-edubezval@gmail.com>
 <CAKohponxUWVT1mjRfJarNtj-+=rXNOa_ONHUjmdu_+6N+=ZjPQ@mail.gmail.com>
 <20141127140803.GA3342@developer>
Message-ID: <CAKohpok90KG7ZcY8qq7g-VmhPSCsn83Ut_K_QJqC2b+efWiXkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2014 at 19:38, Eduardo Valentin <edubezval@gmail.com> wrote:
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Ok.
>
> though.. "normal practice" says  ack's are oftern used by the maintainer
> of the affected code (quoting Documentation/SubmittingPatches) :-)

Hehe :)

Another paragraph from the same file:

Acked-by: does not necessarily indicate acknowledgement of the entire patch.
For example, if a patch affects multiple subsystems and has an Acked-by: from
one subsystem maintainer then this usually indicates acknowledgement of just
the part which affects that maintainer's code.  Judgement should be used here.
When in doubt people should refer to the original discussion in the mailing
list archives.

So my Acked-by was as cpufreq subsystem Maintainer :)
