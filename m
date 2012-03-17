From: ccross@android.com (Colin Cross)
Date: Sat, 17 Mar 2012 12:21:34 -0700
Subject: [PATCHv2 3/5] cpuidle: add support for states that affect
 multiple cpus
In-Reply-To: <4F6483BA.8050103@ti.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
 <1331749794-8056-4-git-send-email-ccross@android.com>
 <4F6483BA.8050103@ti.com>
Message-ID: <CAMbhsRQDdXcKVp-_RNe-0i7YYLr4vKDDXqVw_eP4VsmfbFNtYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 5:29 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:

<snip>

> While playing around with this version, I noticed that the
> 'alive_count' is ever incrementing which will lead to
> coupled idle state not being attempted after one CPU offline
> attempt.
>
> Fix in end of the email for the same. With it, coupled states
> continue to work with CPU online/offline transitions.
>
> Feel free to fold it into original patch. Attached
> the same in case mailer eat tabs.

<snip>

Thanks, Kevin reported this issue and I'll fix it in the next version.
