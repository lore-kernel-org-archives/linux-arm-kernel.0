From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 25 Feb 2015 09:15:32 +0530
Subject: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <7h8ufn8c8q.fsf@deeprootsystems.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>	<be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>	<7ha904b6hp.fsf@deeprootsystems.com>	<CAKohpo=CRkJTkp2FXgYNwd2eEtMVRFuwJ=GPtX7+9WnQD6CK2Q@mail.gmail.com>
 <7h8ufn8c8q.fsf@deeprootsystems.com>
Message-ID: <54ED455C.3010700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 10:42 PM, Kevin Hilman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

> s/they share clock lines/they share clock and/or voltage lines/

Hmm, will update that.

> OK, fair enough.  Looks like it's been thought through.  
> 
> However, in the end, I don't think it's going to avoid the "help of some
> algorithms."  The flag will tell you it's shared, but not how, and that
> will likely still need to be determined.

What did you mean by 'how' here? You wanted to say which devices share the
OPP? Yeah, a small piece of code is required and that's present in my patchset.
