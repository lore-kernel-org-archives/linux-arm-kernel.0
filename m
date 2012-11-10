From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 10 Nov 2012 22:13:53 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Staticly define parent clock of "camera"
 clock
In-Reply-To: <509e6047.a766980a.0f91.14f6@mx.google.com>
References: <1352556477-3700-1-git-send-email-y>
 <509e6047.a766980a.0f91.14f6@mx.google.com>
Message-ID: <509EC391.9090506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2012 03:07 PM, dron0gus at gmail.com wrote:
> From: Andrey Gusakov<dron_gus@mail.ru>
>
> The "camera" clock have only one parent. Define it staticly and
> remove unused source clock list.
>
> Signed-off-by: Andrey Gusakov<dron0gus@gmail.com>

Reviewed-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
