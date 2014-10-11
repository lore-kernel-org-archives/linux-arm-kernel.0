From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Sat, 11 Oct 2014 09:45:21 -0700
Subject: [PATCH] arm64: Fix compile error seen in non-SMP builds
In-Reply-To: <20141011131618.GA4043@lerouge>
References: <1412990134-31186-1-git-send-email-linux@roeck-us.net>
 <20141011131618.GA4043@lerouge>
Message-ID: <CAADnVQK+E94r2YvbOa+_VdDqvU0ywGaAtQfXy6k2qQu8rfNoOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 11, 2014 at 6:16 AM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
>
> Note, ARM64 is one of the archs I couldn't test due to the lack of a
> nolibc cross compiler in https://www.kernel.org/pub/tools/crosstool/

that table is not up to date. There is one there for aarch64:
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/
